From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3 of 5] virtio: support unlocked queue kick
Date: Thu, 3 Nov 2011 03:52:11 -0400
Message-ID: <20111103075211.GD6993__11963.6955242187$1320306745$gmane$org@infradead.org>
References: <patchbomb.1320306168@localhost6.localdomain6>
	<c0db93dbb414ab6dbcde.1320306171@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <c0db93dbb414ab6dbcde.1320306171@localhost6.localdomain6>
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

On Thu, Nov 03, 2011 at 06:12:51PM +1030, Rusty Russell wrote:
> Based on patch by Christoph for virtio_blk speedup:

Please credit it to Stefan - he also sent a pointer to his original
version in reply to the previous thread.

Also shouldn't virtqueue_kick have kerneldoc comments?


I also notices that you documented the functions bother here and in
the first patch in the headers.  At least historically the kerneldoc
tools didn't parse comments at declarations, but only at the function
defintions.  Did you check these actually get picked up?
