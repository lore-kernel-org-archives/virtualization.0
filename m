From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCHv8 0/3]virtio_console: Add rproc_serial driver
Date: Mon, 10 Dec 2012 11:24:43 +0530
Message-ID: <20121210055443.GB17187@amit.redhat.com>
References: <1351587113-2566-1-git-send-email-sjur@brendeland.net>
	<20121108090624.GB31962@amit.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121108090624.GB31962@amit.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sjur =?iso-8859-1?Q?Br=E6ndeland?= <sjur@brendeland.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Sjur =?iso-8859-1?Q?Br=E6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Thu) 08 Nov 2012 [10:06:24], Amit Shah wrote:
> On (Tue) 30 Oct 2012 [09:51:50], Sjur Br=E6ndeland wrote:
> > From: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
> > =

> > This patch-set introduces a new virtio type "rproc_serial" for communic=
ating
> > with remote processors over shared memory. The driver depends on the
> > the remoteproc framework. As preparation for introducing "rproc_serial"
> > I've done a refactoring of the transmit buffer handling.
> =

> Thanks, Sjur.
> =

> Please pick the virtio spec from
> =

> https://github.com/rustyrussell/virtio-spec
> =

> and update the spec with info for remote-proc.

Hi Sjur,

I didn't hear back from you on this..

		Amit
