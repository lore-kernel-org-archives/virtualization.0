From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCHv2] Revert "virtio_console: Initialize
	guest_connected=true for rproc_serial"
Date: Mon, 18 Mar 2013 10:57:00 +0530
Message-ID: <20130318052700.GA18030@amit.redhat.com>
References: <1363014900-6425-1-git-send-email-sjur.brandeland@stericsson.com>
	<20130312073446.GB6786@amit.redhat.com>
	<CANHm3PgQuT=98dM2gU8mkN=RxzD9ruQ+cqa_NGKv2kZwS46c=Q@mail.gmail.com>
	<20130313100322.GB16740@amit.redhat.com>
	<1363173048-8247-1-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1363173048-8247-1-git-send-email-sjur.brandeland@stericsson.com>
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

On (Wed) 13 Mar 2013 [12:10:48], sjur.brandeland@stericsson.com wrote:
> From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>
> =

> =

> This reverts commit 8078db789a92b10ff6e2d713231b5367e014c53b, and
> adds a lengthy comment explaining the problem area.
> =

> The reverted patch caused opening of ports to fail for rproc_serial.
> In probe guest_connected was set to true, but port_fops_open()
> fails with -EMFILE if guest_connected already is true.
> =

> Signed-off-by: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>

Acked-by: Amit Shah <amit.shah@redhat.com>

		Amit
