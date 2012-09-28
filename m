From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCHv6 0/3] virtio_console: Add rproc_serial device
Date: Fri, 28 Sep 2012 18:18:10 +0530
Message-ID: <20120928124810.GB25916@amit.redhat.com>
References: <1348580837-10919-1-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1348580837-10919-1-git-send-email-sjur.brandeland@stericsson.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, sjurbren@stericsson.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) 25 Sep 2012 [15:47:14], sjur.brandeland@stericsson.com wrote:
> From: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
> =

> I thought rebasing rproc_serial to linux-next was going to be trivial.
> But when starting the merge I realized that I had to refactor the
> the patches from  Masami Hiramatsu. The splice support has the same issue
> as I faced, with different type of buffers in the out_vq.
> So I ended up refactoring the splice functionality. The code
> size got smaller so hopefully this a step in the right direction.
> =

> This refactoring also make introduction of rproc_serial cleaner.
> =

> As requested I also added a patch for not initializing buffers.
> =

> I have tested the VIRTIO_CONSOLE device by looping large amount of data
> through character device and tty, with lockdep and slub-debug on.
> This looks stable for me. I've also done a simple test of splice.

Thanks; I just passed these patches through my testsuite and things
are working fine.  I'll review them in some time.

		Amit
