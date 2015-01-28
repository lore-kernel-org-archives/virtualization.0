From: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
Subject: Re: memory barriers in virtq.lua?
Date: Wed, 28 Jan 2015 12:27:27 +0200
Message-ID: <CADDJ2=M6hwFwooXqUjUc9+JxjW1sVYvKhY9dBavrmMUrej6Ysw__42080.5913433016$1422457790$gmane$org@mail.gmail.com>
References: <20150127160126.GA10651@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150127160126.GA10651@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Luke Gorrie <luke@snabb.co>
Cc: "snabb-devel@googlegroups.com" <snabb-devel@googlegroups.com>, VirtualOpenSystems Technical Team <tech@virtualopensystems.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hello Michael,


On Tue, Jan 27, 2015 at 6:01 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> Hi Nikolay,
> I poked at src/lib/virtio/virtq.lua a bit -
> I was surprised to find no explicit CPU memory
> barriers in the virtq implementation.
> These are typically required when using virtio
> on smp machines - the spec actually mention where
> barriers are necessary.
> Are the barriers implicit somehow for lua?
> I'd be curious to learn.
>


thanks for looking at our code and providing your feedback.

The virtq.lua implements the virtq operations from a device point of
view. We compile this with LuaJIT which is guaranteed to not reorder
operations [1]. We also target the x86 architecture, which is
guaranteed to not reorder stores [2]:
"Stores Are Seen in a Consistent Order by Other Processors".
We rely on both these facts and don't use barrier in the virtq code.
However I do agree that we'll have to put barriers once we switch to
other architectures and/or LuaJIT implements ordering optmisations.

Finally, I checked the virtio 1.0 spec again and didn't see any
explicit mentioning of memory barriers regarding the device side of
the spec. There are several places where memory barriers are mentioned
and these all are about the driver. Maybe they are omitted because
they are implicit somehow? Please clarify.

regards,
Nikolay Nikolaev

[1] https://www.freelists.org/post/luajit/Compiler-loadstore-barrier-volatile-pointer-barriers-in-general,1
[2] http://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-vol-3a-part-1-manual.pdf
 - 8.2.3.7

>
> Thanks,
>
> --
> MST
