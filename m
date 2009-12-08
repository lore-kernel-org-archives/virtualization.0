From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio spec: add virtio-blk max sectors feature
Date: Tue, 8 Dec 2009 16:18:00 +1030
Message-ID: <200912081618.00714.rusty__23961.9808075533$1260251335$gmane$org@rustcorp.com.au>
References: <OF38B713F7.02DD66D1-ONC2257681.002F3CAD-C2257681.002FDEA6@il.ibm.com>
	<4B178BCE.7030003@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4B178BCE.7030003@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Avishay Traeger1 <AVISHAY@il.ibm.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 3 Dec 2009 08:28:38 pm Avi Kivity wrote:
> On 12/03/2009 10:42 AM, Avishay Traeger1 wrote:
> > I previously submitted a patch to have the guest virtio-blk driver get the
> > value for the maximum I/O size from the host bdrv, rather than assume that
> > there is no limit.  Avi requested that I first patch the virtio spec
> > (http://ozlabs.org/~rusty/virtio-spec/).  Below is that patch.
> >
> > Please CC me on replies, as I am not subscribed.
> >
> >    
> 
> Copying Rusty and virtualization@.

Thanks Avi...

Avishay; this would be the total sectors in an I/O, as separate from SIZE_MAX
(maximum size of any single scatterlist entry) and SEG_MAX (maximum number of
scatterlist entries)?

Seems like a reasonable idea; esp if you need it.

Thanks!
Rusty.
