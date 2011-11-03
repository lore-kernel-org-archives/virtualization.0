From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2 of 5] virtio: rename virtqueue_add_buf_gfp to
	virtqueue_add_buf
Date: Thu, 3 Nov 2011 03:50:07 -0400
Message-ID: <20111103075007.GC6993@infradead.org>
References: <patchbomb.1320306168@localhost6.localdomain6>
	<07aa6e8fcfc2bcba854e.1320306170@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <07aa6e8fcfc2bcba854e.1320306170@localhost6.localdomain6>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: MichaelS.Tsirkist@redhat.com, Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 03, 2011 at 06:12:50PM +1030, Rusty Russell wrote:
> Remove wrapper functions. This makes the allocation type explicit in
> all callers; I used GPF_KERNEL where it seemed obvious, left it at
> GFP_ATOMIC otherwise.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
