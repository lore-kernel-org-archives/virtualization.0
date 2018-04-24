From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/6] virtio-console: spec compliance fixes
Date: Tue, 24 Apr 2018 21:41:29 +0300
Message-ID: <20180424214104-mutt-send-email-mst__26841.4362836213$1524595192$gmane$org@kernel.org>
References: <1524248223-393618-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1524248223-393618-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 20, 2018 at 09:17:59PM +0300, Michael S. Tsirkin wrote:
> Turns out virtio console tries to take a buffer out of an active vq.
> Works by sheer luck, and is explicitly forbidden by spec.  And while
> going over it I saw that error handling is also broken -
> failure is easy to trigger if I force allocations to fail.
> 
> Lightly tested.

Amit - any feedback before I push these patches?

> Michael S. Tsirkin (6):
>   virtio_console: don't tie bufs to a vq
>   virtio: add ability to iterate over vqs
>   virtio_console: free buffers after reset
>   virtio_console: drop custom control queue cleanup
>   virtio_console: move removal code
>   virtio_console: reset on out of memory
> 
>  drivers/char/virtio_console.c | 155 ++++++++++++++++++++----------------------
>  include/linux/virtio.h        |   3 +
>  2 files changed, 75 insertions(+), 83 deletions(-)
> 
> -- 
> MST
> 
