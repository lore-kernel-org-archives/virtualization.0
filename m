From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_balloon: set DRIVER_OK before using device
Date: Mon, 09 Mar 2015 17:33:35 +1030
Message-ID: <87385ey7nc.fsf__21951.0685689331$1425885435$gmane$org@rustcorp.com.au>
References: <1425474779-29412-1-git-send-email-mst@redhat.com>
	<877fuwjgqw.fsf@rustcorp.com.au>
	<20150305083905.GA11474@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150305083905.GA11474@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Thu, Mar 05, 2015 at 01:24:47PM +1030, Rusty Russell wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> > virtio spec requires that all drivers set DRIVER_OK
>> > before using devices. While balloon isn't yet
>> > included in the virtio 1 spec, previous spec versions
>> > also required this.
>> >
>> > virtio balloon might violate this rule: probe calls
>> > kthread_run before setting DRIVER_OK, which might run
>> > immediately and cause balloon to inflate/deflate.
>> >
>> > To fix, call virtio_device_ready before running the kthread.
>> >
>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> 
>> Replied, CC'd stable.
>
> Did you mean applied?

I stand erected.

Franks,
Rusty.
