From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH] virtio_net tx performance fix
Date: Mon, 28 Jan 2008 09:32:56 -0600
Message-ID: <479DF5A8.8050103__41734.1309869245$1201535043$gmane$org@us.ibm.com>
References: <1201479224.3047.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1201479224.3047.37.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dor.laor@qumranet.com
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Dor,

How are you measuring performance?  The numbers I've gotten with netperf 
before and after your patch are:

tx - 647.27mbit
rx - 89.22

tx - 27.82
rx - 79.93

So this patch is pretty much killing performance for netperf.

Dor Laor wrote:
> There was a problem with the location of the notify call in
> add_buff function:
> When VRING_USED_F_NO_NOTIFY is set, the host does not kick the
> guest when packets were transmitted, as a result the guest runs
> out of tx buffers sometimes.

But even if F_NO_NOTIFY is set, if the tx buffer is full, we notify the 
guest, so this prevents that from happening.

>  This is fine but the problem lies
> when add_buf fails, it called notify and the host sends all the
> pending tx pkts. When enable_cb was called, more_used(vq) returned
> false so eventually the skb was dropped.
>   

I'm having a tough time following this part.  If add_buf fails, we 
notify unconditionally (which is, I think what we want).  I'm not sure 
how that relates to a packet getting dropped though.

Regards,

Anthony Liguori
