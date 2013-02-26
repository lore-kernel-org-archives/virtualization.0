From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 02/16] virtio_ring: virtqueue_add_sgs, to add multiple sgs.
Date: Tue, 26 Feb 2013 15:44:26 +1030
Message-ID: <87bob7fyh9.fsf@rustcorp.com.au>
References: <1361260594-601-1-git-send-email-rusty@rustcorp.com.au>
	<1361260594-601-3-git-send-email-rusty@rustcorp.com.au>
	<20130224221255.GA5300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130224221255.GA5300@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Tue, Feb 19, 2013 at 06:26:20PM +1030, Rusty Russell wrote:
>> virtio_scsi can really use this, to avoid the current hack of copying
>> the whole sg array.  Some other things get slightly neater, too.
>> 
>> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>
> Hmm, this makes add_buf a bit slower. virtio_test results
> (I'll send a patch to update the test shortly):
>
> Before:
> 0.09user 0.01system 0:00.12elapsed 91%CPU (0avgtext+0avgdata 480maxresident)k
> 0inputs+0outputs (0major+145minor)pagefaults 0swaps
>
> After:
> 0.11user 0.01system 0:00.13elapsed 90%CPU (0avgtext+0avgdata 480maxresident)k
> 0inputs+0outputs (0major+145minor)pagefaults 0swaps

Interesting: how much of this is due to the shim in virtqueue_add_buf()
to clean up the sg arrays?

(Perhaps we should make virtio_test run for longer, too).

BTW, you might be interested in:
        https://github.com/rustyrussell/stats.git

Which provides a useful filter for multiple results.

Cheers,
Rusty.
