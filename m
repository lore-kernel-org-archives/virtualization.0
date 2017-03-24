From: Ladi Prosek <lprosek@redhat.com>
Subject: Re: [PATCH] virtio_balloon: prevent uninitialized variable use
Date: Fri, 24 Mar 2017 21:11:25 +0100
Message-ID: <CABdb737ghQYPjc3qNXwfcfcsin=j1BaRGyQTM7XwftCTsXbz9A@mail.gmail.com>
References: <20170323151728.679684-1-arnd@arndb.de>
	<de7e1bac-d5e9-a984-499f-6e7e0a48b78e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <de7e1bac-d5e9-a984-499f-6e7e0a48b78e@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Hildenbrand <david@redhat.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>, Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, Konstantin Neumoin <kneumoin@virtuozzo.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Minchan Kim <minchan@kernel.org>, "Denis V. Lunev" <den@openvz.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 24, 2017 at 7:38 PM, David Hildenbrand <david@redhat.com> wrote:
> On 23.03.2017 16:17, Arnd Bergmann wrote:
>> The latest gcc-7.0.1 snapshot reports a new warning:
>>
>> virtio/virtio_balloon.c: In function 'update_balloon_stats':
>> virtio/virtio_balloon.c:258:26: error: 'events[2]' is used uninitialized in this function [-Werror=uninitialized]
>> virtio/virtio_balloon.c:260:26: error: 'events[3]' is used uninitialized in this function [-Werror=uninitialized]
>> virtio/virtio_balloon.c:261:56: error: 'events[18]' is used uninitialized in this function [-Werror=uninitialized]
>> virtio/virtio_balloon.c:262:56: error: 'events[17]' is used uninitialized in this function [-Werror=uninitialized]
>>
>> This seems absolutely right, so we should add an extra check to
>> prevent copying uninitialized stack data into the statistics.
>> From all I can tell, this has been broken since the statistics code
>> was originally added in 2.6.34.
>>
>> Fixes: 9564e138b1f6 ("virtio: Add memory statistics reporting to the balloon driver (V4)")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/virtio/virtio_balloon.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index 4e1191508228..cd5c54e2003d 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -254,12 +254,14 @@ static void update_balloon_stats(struct virtio_balloon *vb)
>>
>>       available = si_mem_available();
>>
>> +#ifdef CONFIG_VM_EVENT_COUNTERS
>>       update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_IN,
>>                               pages_to_bytes(events[PSWPIN]));
>>       update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_OUT,
>>                               pages_to_bytes(events[PSWPOUT]));
>>       update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
>>       update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
>> +#endif
>>       update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMFREE,
>>                               pages_to_bytes(i.freeram));
>>       update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMTOT,

This will leave four uninitialized slots in vb->stats if
CONFIG_VM_EVENT_COUNTERS is not defined. update_balloon_stats should
have

  BUG_ON(idx < VIRTIO_BALLOON_S_NR);

at the end.

You need to make sure that vb->stats is smaller, either by using
something else than VIRTIO_BALLOON_S_NR for its size or something else
than sizeof(vb->stats) as the last argument to sg_init_one in this
file.

> CC'ing Ladi

Thanks!

> --
>
> Thanks,
>
> David
