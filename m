From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/5] virtio: move queue_index and num_free fields into
	core struct virtqueue.
Date: Wed, 17 Oct 2012 00:49:34 +1030
Message-ID: <878vb6pki1.fsf@rustcorp.com.au>
References: <1350394252-23934-1-git-send-email-rusty@rustcorp.com.au>
	<20121016135322.GB12972@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121016135322.GB12972@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Wed, Oct 17, 2012 at 12:00:48AM +1030, Rusty Russell wrote:
>>   * @priv: a pointer for the virtqueue implementation to use.
>> + * @index: the zero-based ordinal number for this queue.
>> + * @num_free: number of buffers we expect to be able to fit.
>
> Only it's not exactly buffers: a single buffer can use
> multiple s/g entries, right?
> Maybe clarify as 'linear buffers'?

Yes, it needs clarification, but I don't think I can do so tersely.

Here's what I ended up with:

 * @num_free: number of elements we expect to be able to fit.
 *
 * A note on @num_free: with indirect buffers, each buffer needs one
 * element in the queue, otherwise a buffer will need one element per
 * sg element.

Thanks,
Rusty.
