From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/1] Add virtio-input driver.
Date: Thu, 19 Mar 2015 14:35:45 +0100
Message-ID: <20150319141302-mutt-send-email-mst__22225.5393550315$1426772169$gmane$org@redhat.com>
References: <1426756391-26585-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1426756391-26585-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 19, 2015 at 10:13:10AM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> This patch adds a virtio driver for input devices.
> 
> Specification:
>   https://www.kraxel.org/cgit/virtio-spec/log/?h=virtio-input
>   https://www.kraxel.org/virtio/virtio-v1.0-csprd03-virtio-input.html#x1-2640007


OK, I don't know which thread should I use for spec discussions.
Referring to that:

	"See file:///usr/include/linux/input.h."

Is likely not present on many systems, or might not include
the info you refer to.

 "type, code and value are filled according to the linux input layer
 (evdev) interface"

Which version?  How will non-linux guests know what to implement?


> 
> Qemu patches;
>   https://lists.gnu.org/archive/html/qemu-devel/2015-03/threads.html#03973
> 
> Gerd Hoffmann (1):
>   Add virtio-input driver.
> 
>  drivers/virtio/Kconfig            |  10 ++
>  drivers/virtio/Makefile           |   1 +
>  drivers/virtio/virtio_input.c     | 313 ++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_ids.h   |   1 +
>  include/uapi/linux/virtio_input.h |  65 ++++++++
>  5 files changed, 390 insertions(+)
>  create mode 100644 drivers/virtio/virtio_input.c
>  create mode 100644 include/uapi/linux/virtio_input.h
> 
> -- 
> 1.8.3.1
