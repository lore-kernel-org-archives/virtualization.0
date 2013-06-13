From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-spec: add field for scsi command size
Date: Thu, 13 Jun 2013 14:12:22 +0930
Message-ID: <87k3lyzknl.fsf@rustcorp.com.au>
References: <20130314111020.GA18050@redhat.com> <5141E990.7070609@redhat.com>
	<20130314173918.GB29411@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130314173918.GB29411@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Thu, Mar 14, 2013 at 04:15:28PM +0100, Paolo Bonzini wrote:
>> Il 14/03/2013 12:10, Michael S. Tsirkin ha scritto:
>> > Add field for guest to specify command size for virtio-blk.
>> > 
>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> OK, but Rusty usually tweaks wording anyway.
> Rusty want to apply and make changes Paolo suggested yourself
> or want me to?

(MST drew my attention back to this)

Please do.  And please add a note about this feature: that without it,
the descriptor layout must be on the right boundaries for historical
reasons.

Thanks,
Rusty.
