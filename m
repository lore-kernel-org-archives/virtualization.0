From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] virtio_blk: Drop unused request tracking list
Date: Mon, 2 Apr 2012 15:29:30 +0100
Message-ID: <CAJSP0QVuFGR2=LwLAgO3BkHoKM7E+rEg=TkzL27uxSqAn7SPmw__42823.9390989349$1333376984$gmane$org@mail.gmail.com>
References: <1333077850-21717-1-git-send-email-asias@redhat.com>
	<CAJSP0QWN2byeZt9RCwgwVp9HuD5G0yha3xNYT+m+OJPS16W8SQ@mail.gmail.com>
	<CAFO3S42y9xYv3i_gffL1qvKmbRTjVVrxdzvj8+vPF-vVYnESNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAFO3S42y9xYv3i_gffL1qvKmbRTjVVrxdzvj8+vPF-vVYnESNQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias.hejun@gmail.com>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Mar 31, 2012 at 11:22 AM, Asias He <asias.hejun@gmail.com> wrote:
> Hi, Stefan
>
> On Fri, Mar 30, 2012 at 6:14 PM, Stefan Hajnoczi <stefanha@gmail.com> wro=
te:
>> On Fri, Mar 30, 2012 at 4:24 AM, Asias He <asias@redhat.com> wrote:
>>> Benchmark shows small performance improvement on fusion io device.
>>>
>>> Before:
>>> =A0seq-read : io=3D1,024MB, bw=3D19,982KB/s, iops=3D39,964, runt=3D 524=
75msec
>>> =A0seq-write: io=3D1,024MB, bw=3D20,321KB/s, iops=3D40,641, runt=3D 516=
01msec
>>> =A0rnd-read : io=3D1,024MB, bw=3D15,404KB/s, iops=3D30,808, runt=3D 680=
70msec
>>> =A0rnd-write: io=3D1,024MB, bw=3D14,776KB/s, iops=3D29,552, runt=3D 709=
63msec
>>>
>>> After:
>>> =A0seq-read : io=3D1,024MB, bw=3D20,343KB/s, iops=3D40,685, runt=3D 515=
46msec
>>> =A0seq-write: io=3D1,024MB, bw=3D20,803KB/s, iops=3D41,606, runt=3D 504=
04msec
>>> =A0rnd-read : io=3D1,024MB, bw=3D16,221KB/s, iops=3D32,442, runt=3D 646=
42msec
>>> =A0rnd-write: io=3D1,024MB, bw=3D15,199KB/s, iops=3D30,397, runt=3D 689=
91msec
>>>
>>> Signed-off-by: Asias He <asias@redhat.com>
>>> ---
>>> =A0drivers/block/virtio_blk.c | =A0 10 ----------
>>> =A01 files changed, 0 insertions(+), 10 deletions(-)
>>
>> Thanks for providing performance results. =A0It's a bit scary that this
>> unused list has an impact...I'm sure we have worse things elsewhere in
>> the KVM storage code path.
>
> Do you find any worse things? I saw your trace work here:
>
> =A0 http://www.linux-kvm.org/page/Virtio/Block/Latency

I haven't updated those results in a long time because I no longer use
that benchmarking environment.

Stefan
