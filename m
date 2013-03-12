From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] Revert "virtio_console: Initialize guest_connected=true
	for rproc_serial"
Date: Tue, 12 Mar 2013 13:04:46 +0530
Message-ID: <20130312073446.GB6786@amit.redhat.com>
References: <1363014900-6425-1-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1363014900-6425-1-git-send-email-sjur.brandeland@stericsson.com>
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
Cc: sjur@brendeland.net, Linus Walleij <linus.walleij@linaro.org>, Erwan Yvin <erwan.yvin@stericsson.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) 11 Mar 2013 [16:15:00], sjur.brandeland@stericsson.com wrote:
> From: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
> =

> This reverts commit 8078db789a92b10ff6e2d713231b5367e014c53b.
> =

> The reverted patch caused opening of ports to fail for rproc_serial.
> In probe guest_connected was set to true, but port_fops_open()
> fails with -EMFILE if guest_connected already is true.

OK, I missed that.  Can you add a comment near the 2nd hunk mentioning
this?


		Amit
