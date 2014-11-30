From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH v7 44/46] virtio_scsi: export to userspace
Date: Sun, 30 Nov 2014 21:43:23 +0000
Message-ID: <CA+V-a8t6Gp8XyCAM8DVFrhyJzN5wdEMv8nn59mCP1FP6QQLwXg__37461.7172558375$1417471037$gmane$org@mail.gmail.com>
References: <1417359787-10138-1-git-send-email-mst@redhat.com>
	<1417359787-10138-45-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1417359787-10138-45-git-send-email-mst@redhat.com>
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
Cc: Bjarke Istrup Pedersen <gurligebis@gentoo.org>, thuth@linux.vnet.ibm.com, Anup Patel <anup.patel@linaro.org>, rusty@au1.ibm.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, dahi@linux.vnet.ibm.com, Sakari Ailus <sakari.ailus@linux.intel.com>, linux-api <linux-api@vger.kernel.org>, pbonzini@redhat.com, Andy Grover <agrover@redhat.com>, David Miller <davem@davemloft.net>, Alexei Starovoitov <ast@plumgrid.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Michael,

Thanks for the patch.

On Sun, Nov 30, 2014 at 3:12 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> Replace uXX by __uXX and _packed by __attribute((packed))
> as seems to be the norm for userspace headers.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

> ---
>  include/uapi/linux/virtio_scsi.h | 74 ++++++++++++++++++++--------------------
>  include/uapi/linux/Kbuild        |  1 +

Probably worth making a separate patch for this ? as it doesnt
match with patch description aswel.

Apart from that patch looks good.

Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Regards,
--Prabhakar Lad
