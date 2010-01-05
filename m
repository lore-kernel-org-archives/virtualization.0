From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [Qemu-devel] Re: [PATCH v2] virtio-blk physical block size
Date: Tue, 5 Jan 2010 20:18:01 +0000
Message-ID: <20100105201801.GK14376__27224.1835170009$1262722881$gmane$org@shareable.org>
References: <1262018363-15871-1-git-send-email-avi@redhat.com>
	<201001041338.52621.rusty@rustcorp.com.au>
	<4B4192A1.3030801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4B4192A1.3030801@redhat.com>
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> Physical block size is the what the logical block size would have been 
> is software didn't suck.  In theory they should be the same, but since 
> compatibility reaons clamp the logical block size to 512, they have to 
> differ.  A disk may have a physical block size of 4096 and emulate 
> logical block size of 512 on top of that using read-modify-write.
> 
> Or so I understand it.

I think that's right, but a side effect is that if you get a power
failure during the read-modify-write, bytes anywhere in 4096 sector
may be incorrect, so journalling (etc.) needs to use 4096 byte blocks
for data integrity, even though the drive emulates smaller writes.

-- Jamie
