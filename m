From: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [RFC V2 4/7] VSOCK: Introduce virtio-vsock.ko
Date: Sat, 05 Jul 2014 09:14:17 +0530
Message-ID: <53B77491.6080107__36424.8199658052$1404866826$gmane$org@gmail.com>
References: <cover.1404529115.git.asias.hejun@gmail.com>
	<f546c3430cbd8b141f7b6aaf4327907909479ae2.1404529115.git.asias.hejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <f546c3430cbd8b141f7b6aaf4327907909479ae2.1404529115.git.asias.hejun@gmail.com>
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
> VM sockets virtio transport implementation. This module runs in guest
> kernel.
>
> Signed-off-by: Asias He <asias@redhat.com>
> ---
>   net/vmw_vsock/virtio_transport.c | 448 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 448 insertions(+)
>   create mode 100644 net/vmw_vsock/virtio_transport.c

This patch also having the coding style problems..

-- 
Regards,
Varka Bhadram
