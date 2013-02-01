From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH] tcm_vhost: Multi-target support
Date: Thu, 31 Jan 2013 23:38:27 -0800
Message-ID: <1359704307.6300.84.camel__31708.7505282418$1359704344$gmane$org@haakon2.linux-iscsi.org>
References: <1359617636-20339-1-git-send-email-asias@redhat.com>
	<510A3935.2030604@redhat.com>
	<1359665976.6300.43.camel@haakon2.linux-iscsi.org>
	<510B3E91.6080006@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <510B3E91.6080006@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2013-02-01 at 12:03 +0800, Asias He wrote:
> On 02/01/2013 04:59 AM, Nicholas A. Bellinger wrote:
> > On Thu, 2013-01-31 at 17:28 +0800, Asias He wrote:
> >> Hello Nicholas,
> >>
> >> On 01/31/2013 03:33 PM, Asias He wrote:
> >>> In order to take advantages of Paolo's multi-queue virito-scsi, we need
> >>> multi-target support in tcm_vhost first. Otherwise all the requests go
> >>> to one queue and other queues are idle.
> >>>

<SNIP>

> >>> @@ -771,14 +799,11 @@ static int vhost_scsi_set_endpoint(
> >>>  		}
> >>>  		tv_tport = tv_tpg->tport;
> >>>  
> >>> -		if (!strcmp(tv_tport->tport_name, t->vhost_wwpn) &&
> >>> -		    (tv_tpg->tport_tpgt == t->vhost_tpgt)) {
> >>> +		if (!strcmp(tv_tport->tport_name, t->vhost_wwpn)) {
> >>>  			tv_tpg->tv_tpg_vhost_count++;
> >>> -			mutex_unlock(&tv_tpg->tv_tpg_mutex);
> >>> -			mutex_unlock(&tcm_vhost_mutex);
> >>>  
> >>>  			mutex_lock(&vs->dev.mutex);
> >>> -			if (vs->vs_tpg) {
> >>> +			if (vs->vs_tpg[tv_tpg->tport_tpgt - 1]) {
> >>>  				mutex_unlock(&vs->dev.mutex);
> >>>  				mutex_lock(&tv_tpg->tv_tpg_mutex);
> >>>  				tv_tpg->tv_tpg_vhost_count--;
> >>> @@ -786,15 +811,17 @@ static int vhost_scsi_set_endpoint(
> >>>  				return -EEXIST;
> >>>  			}
> >>>  
> >>> -			vs->vs_tpg = tv_tpg;
> >>> +			vs->vs_tpg[tv_tpg->tport_tpgt - 1] = tv_tpg;
> >>
> >>
> >> tv_tpg->tport_tpgt starts from 0, right? I thought it starts from 1,
> >> because I always got it starts from 1 in targetcli.
> >>
> >> o- vhost
> >>    o- naa.6001405bd4e8476d
> >>       o- tpg1
> >>          o- luns
> >>             o- lun0
> >>       o- tpg2
> >>          o- luns
> >>             o- lun0
> >>       o- tpg3
> >>          o- luns
> >>             o- lun0
> >>       o- tpg4
> >>          o- luns
> >>             o- lun0
> >>
> > 
> > So at least with iscsi-target, we start from tpgt=1 to avoid some legacy
> > initiators that have issues handling tgpt=0.
> > 
> > Given that rtslib/targetcli currently expect this with the "tpgs"
> > feature is enabled, starting from tpgt=1 with tcm_vhost probably makes
> > the most sense.
> 
> Okay. But tgpt can be 0, right?
> 

Most certainly, in the end it's totally up to the fabric.  ;)
 
> I saw this setup:
> 
>   cd /sys/kernel/config/target
>   mkdir -p core/fileio_0/fileio
>   echo 'fd_dev_name=/home/pbonzini/test.img,fd_dev_size=5905580032' >
> core/fileio_0/fileio/control
>   echo 1 > core/fileio_0/fileio/enable
>   mkdir -p vhost/naa.600140554cf3a18e/tpgt_0/lun/lun_0
>   cd vhost/naa.600140554cf3a18e/tpgt_0
>   ln -sf ../../../../../core/fileio_0/fileio/ lun/lun_0/virtual_scsi_port
>   echo naa.60014053226f0388 > nexus
> 
> And this:
> 
>        ** Setup wwpn and tpgt
>        $ wwpn="naa.0"
>        $ tpgt=/sys/kernel/config/target/vhost/$wwpn/tpgt_0
>        $ nexus=$tpgt/nexus
>        $ mkdir -p $tpgt
>        $ echo -n $wwpn > $nexus
> 
> 

OK, I think you'll want to avoid the extra vs->vs_tpg[tpgt - 1] offset
above to properly support this.

--nab

> 
> >> If it is true. I will cook v2 of this patch.
> >>
> >> Also, the tv_tpg->tport_tpgt can be none-continuous. e.g.
> >>
> >> o- vhost
> >>    o- naa.6001405bd4e8476d
> >>       o- tpg1
> >>          o- luns
> >>             o- lun0
> >>       o- tpg2
> >>          o- luns
> >>             o- lun0
> >>       o- tpg4
> >>          o- luns
> >>             o- lun0
> >>
> >> I will handle this in v2.
> >>
> > 
> > Correct, tpgt values may be optionally non-contiguous up to unsigned
> > short.
> 
> ok.
> 
> > --nab
> > 
> > 
> 
> 
