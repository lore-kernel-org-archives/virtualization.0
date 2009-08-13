From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/3] qemu-kvm: vhost net support
Date: Thu, 13 Aug 2009 14:53:38 +0300
Message-ID: <20090813115337.GA4853__10835.8645732098$1250164638$gmane$org@redhat.com>
References: <20090810192304.GA16781@redhat.com> <4A8325C0.7060001@gmail.com>
	<20090813055941.GB3029@redhat.com> <4A83FA98.1010708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A83FA98.1010708@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gregory Haskins <gregory.haskins@gmail.com>
Cc: avi@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 13, 2009 at 07:35:52AM -0400, Gregory Haskins wrote:
> Michael S. Tsirkin wrote:
> > On Wed, Aug 12, 2009 at 04:27:44PM -0400, Gregory Haskins wrote:
> >> Michael S. Tsirkin wrote:
> >>> This adds support for vhost-net virtio kernel backend.
> >>>
> >>> This is RFC, but works without issues for me.
> >>>
> >>> Still needs to be split up, tested and benchmarked properly,
> >>> but posting it here in case people want to test drive
> >>> the kernel bits I posted.
> >> This has a large degree of rejects against qemu-kvm.git/master.  What
> >> tree does this apply to?
> >>
> >> -Greg
> >>
> > 
> > Likely that tree has advanced since.
> > This is on top of commit b6bbd41fac4b6fb0efc65e083d2151ce1521f615.
> > 
> 
> 
> Hmm....better, but I still get rejects.  Of particular concern is this
> one in net.c:
> 
> @@ -1903,7 +1903,7 @@ static TAPState *net_tap_init(VLANState *vlan,
> const char *model,
>  typedef struct RAWState {
>      VLANClientState *vc;
>      int fd;
> -    uint8_t buf[4096];
> +    uint8_t buf[65000];
>      int promisc;
>  } RAWState;
> 
> 
> I do not see any occurrence of "RAWState" in b6bbd41f (or master, for
> that matter).  There is probably an operator error somewhere in here ;),

Yes. Mine :)

> but any help getting this working is appreciated.

I reposted a clean one which is against latest bits earlier today.
Look for PATCHv2 in your inbox.

> Do you have a git tree I can pull somewhere?
> Kind Regards,
> -Greg
> 

Thanks for the patience,

-- 
MST
