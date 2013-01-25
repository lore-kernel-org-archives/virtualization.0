From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio_console: Don't access uninitialized data.
Date: Fri, 25 Jan 2013 14:38:01 +0530
Message-ID: <20130125090801.GA30483@amit.redhat.com>
References: <1358425292-4449-1-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1358425292-4449-1-git-send-email-sjur.brandeland@stericsson.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: sjur.brandeland@stericsson.com
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Thu) 17 Jan 2013 [13:21:32], sjur.brandeland@stericsson.com wrote:
> From: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
> =

> Don't access uninitialized work-queue when removing device.
> The work queue is initialized only if the device multi-queue.
> So don't call cancel_work unless this is a multi-queue device.
> =

> This fixes the following panic:

[snip]

> Signed-off-by: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>

Acked-by: Amit Shah <amit.shah@redhat.com>

> This fix is intended of v3.8.

Should also be CC'ed to stable@

Thanks,

		Amit
