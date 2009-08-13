From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/3] qemu-kvm: vhost net support
Date: Thu, 13 Aug 2009 08:59:41 +0300
Message-ID: <20090813055941.GB3029__44995.4612566673$1250143308$gmane$org@redhat.com>
References: <20090810192304.GA16781@redhat.com> <4A8325C0.7060001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A8325C0.7060001@gmail.com>
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

On Wed, Aug 12, 2009 at 04:27:44PM -0400, Gregory Haskins wrote:
> Michael S. Tsirkin wrote:
> > This adds support for vhost-net virtio kernel backend.
> > 
> > This is RFC, but works without issues for me.
> > 
> > Still needs to be split up, tested and benchmarked properly,
> > but posting it here in case people want to test drive
> > the kernel bits I posted.
> 
> This has a large degree of rejects against qemu-kvm.git/master.  What
> tree does this apply to?
> 
> -Greg
> 

Likely that tree has advanced since.
This is on top of commit b6bbd41fac4b6fb0efc65e083d2151ce1521f615.

-- 
MST
