From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/6] virtio: virtqueue ops cleanup
Date: Mon, 19 Apr 2010 23:49:54 +0300
Message-ID: <20100419204953.GA19464@redhat.com>
References: <cover.1271078235.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1271078235.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 12, 2010 at 04:18:19PM +0300, Michael S. Tsirkin wrote:
> This patchset does the following:
> - add inline wrappers converting the above to virtqueue_kick(dev->vq)
> - convert all users to this API
> - remove vq_ops indirection, implementing virtqueue_xx directly
>   in virtio_ring

Ping.
what's the thinking on this patchset?
The reason I want it in now is because I have
several improvements for the APIs in mind,
and with less layers it's much easier to
extend things.

-- 
MST
