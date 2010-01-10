From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] Re: [PATCH v2] virtio-blk physical block size
Date: Sun, 10 Jan 2010 14:35:48 +0200
Message-ID: <4B49C9A4.10201__31601.1638766669$1263127086$gmane$org@redhat.com>
References: <1262018363-15871-1-git-send-email-avi@redhat.com>
	<201001041338.52621.rusty@rustcorp.com.au>
	<20100104083035.GA7461@lst.de>
	<201001052326.33216.rusty@rustcorp.com.au>
	<4B433783.6090400@redhat.com>
	<20100105201615.GJ14376@shareable.org>
	<20100108154044.GB14634@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100108154044.GB14634@lst.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jamie Lokier <jamie@shareable.org>, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 01/08/2010 05:40 PM, Christoph Hellwig wrote:
> Maybe we should pick one on image creation and then stick to it.  For an
> image format we could write down this information in the image, but for
> a raw images that's impossible.
>    

The management system should remember it (like it remembers which images 
belong to which guest, and how to expose them).

-- 
error compiling committee.c: too many arguments to function
