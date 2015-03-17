From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio fixes pull for 4.0?
Date: Tue, 17 Mar 2015 12:20:00 +1030
Message-ID: <8761a0mlyv.fsf__33647.144251927$1426557564$gmane$org@rustcorp.com.au>
References: <20150307193049.GA32459@redhat.com>
	<87y4n6wsmo.fsf@rustcorp.com.au>
	<20150316060449-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150316060449-mutt-send-email-mst@redhat.com>
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Mon, Mar 09, 2015 at 05:43:19PM +1030, Rusty Russell wrote:
>> > I think it's a good idea to merge these patches (maybe except the
>> > !TASK_RUNNING thing) sooner rather than later, to make sure people have
>> > the time to test the fixes properly.  Would you like me to pack up (some
>> > of them) them up and do a pull request?
>> 
>> I'm waiting a bit longer, since they seem to still be tricking in.
>
> I don't think there was a pull request since rc1 which
> makes me a bit anxious. Any outstanding issues?

Well, I was hoping for an ack on your mmio patches.  But the weekend
is over, so I've pushed and sent Linus a pull request.

Cheers,
Rusty.
