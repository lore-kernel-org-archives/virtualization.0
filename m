From: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [RFC V2 3/7] VSOCK: Introduce virtio-vsock-common.ko
Date: Sat, 05 Jul 2014 09:12:46 +0530
Message-ID: <53B77436.3050208__28971.9292115935$1404866815$gmane$org@gmail.com>
References: <cover.1404529115.git.asias.hejun@gmail.com>
	<d6bb5a91b8433b7eec5692756be00e49a587737a.1404529115.git.asias.hejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <d6bb5a91b8433b7eec5692756be00e49a587737a.1404529115.git.asias.hejun@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias.hejun@gmail.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On Saturday 05 July 2014 08:53 AM, Asias He wrote:
> From: Asias He <asias@redhat.com>
>
> This module contains the common code and header files for the following
> virtio-vsock and virtio-vhost kernel modules.
>
> Signed-off-by: Asias He <asias@redhat.com>
> ---
>   include/linux/virtio_vsock.h                       |  207 ++++
>   include/uapi/linux/virtio_ids.h                    |    1 +
>   .../uapi/linux/{virtio_ids.h => virtio_vsock.h}    |   78 +-
>   net/vmw_vsock/virtio_transport_common.c            | 1220 ++++++++++++++++++++
>   4 files changed, 1485 insertions(+), 21 deletions(-)
>   create mode 100644 include/linux/virtio_vsock.h
>   copy include/uapi/linux/{virtio_ids.h => virtio_vsock.h} (50%)
>   create mode 100644 net/vmw_vsock/virtio_transport_common.c
>
This patch having coding style problems. Run checkpatch.pl on this.

--
Regards,
Varka Bhadram.
