From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] virtio_blk: Drop unused request tracking list
Date: Fri, 30 Mar 2012 11:14:22 +0100
Message-ID: <CAJSP0QWN2byeZt9RCwgwVp9HuD5G0yha3xNYT+m+OJPS16W8SQ@mail.gmail.com>
References: <1333077850-21717-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1333077850-21717-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 30, 2012 at 4:24 AM, Asias He <asias@redhat.com> wrote:
> Benchmark shows small performance improvement on fusion io device.
>
> Before:
> =A0seq-read : io=3D1,024MB, bw=3D19,982KB/s, iops=3D39,964, runt=3D 52475=
msec
> =A0seq-write: io=3D1,024MB, bw=3D20,321KB/s, iops=3D40,641, runt=3D 51601=
msec
> =A0rnd-read : io=3D1,024MB, bw=3D15,404KB/s, iops=3D30,808, runt=3D 68070=
msec
> =A0rnd-write: io=3D1,024MB, bw=3D14,776KB/s, iops=3D29,552, runt=3D 70963=
msec
>
> After:
> =A0seq-read : io=3D1,024MB, bw=3D20,343KB/s, iops=3D40,685, runt=3D 51546=
msec
> =A0seq-write: io=3D1,024MB, bw=3D20,803KB/s, iops=3D41,606, runt=3D 50404=
msec
> =A0rnd-read : io=3D1,024MB, bw=3D16,221KB/s, iops=3D32,442, runt=3D 64642=
msec
> =A0rnd-write: io=3D1,024MB, bw=3D15,199KB/s, iops=3D30,397, runt=3D 68991=
msec
>
> Signed-off-by: Asias He <asias@redhat.com>
> ---
> =A0drivers/block/virtio_blk.c | =A0 10 ----------
> =A01 files changed, 0 insertions(+), 10 deletions(-)

Thanks for providing performance results.  It's a bit scary that this
unused list has an impact...I'm sure we have worse things elsewhere in
the KVM storage code path.

Reviewed-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
