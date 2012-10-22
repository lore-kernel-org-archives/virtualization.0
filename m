From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCHv7 0/4] virtio_console: Add rproc_serial driver
Date: Mon, 22 Oct 2012 18:30:52 +0530
Message-ID: <20121022130052.GG25057@amit.redhat.com>
References: <1350287856-5284-1-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1350287856-5284-1-git-send-email-sjur.brandeland@stericsson.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
List-Id: virtualization@lists.linuxfoundation.org

Hello Sjur,

On (Mon) 15 Oct 2012 [09:57:32], sjur.brandeland@stericsson.com wrote:
> From: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
> =

> This patch-set introduces a new virtio type "rproc_serial" for communicat=
ing
> with remote processors over shared memory. The driver depends on the
> the remoteproc framework. As preparation for introducing "rproc_serial"
> I've done a refactoring of the transmit buffer handling.
> =

> This patch-set is a rework of the patch-set from Sept 25th, hopefully all
> review comments has been addressed.
> =

> The fist patch is a bugfix and migth be applicable for 3.7.

Looks good,

Acked-by: Amit Shah <amit.shah@redhat.com>

include/linux/virtio_ids.h has moved to include/uapi/linux/.  Last
patch has to be re-spun for that.

Otherwise, I just checked if comments from the previous submission
were addressed.  The virtio-console test suite passes fine, so I
didn't really go through everything again.

Thanks,

		Amit
