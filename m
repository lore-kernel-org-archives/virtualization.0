From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build regressions/improvements in v4.7-rc6
Date: Mon, 4 Jul 2016 10:21:45 +0200
Message-ID: <CAMuHMdUDO0k86TTVTiCQGS2=H0dEXVW77NNfvt7fvWbwdpS=2g__31897.7043069482$1467620533$gmane$org@mail.gmail.com>
References: <1467619946-424-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1467619946-424-1-git-send-email-geert@linux-m68k.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 4, 2016 at 10:12 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.7-rc6[1] to v4.7-rc5[3], the summaries are:
>   - build errors: +3/-2

  + /home/kisskb/slave/src/drivers/vhost/vhost.c: error: call to
'__compiletime_assert_844' declared with attribute error: BUILD_BUG_ON
failed: __alignof__ *vq->avail > VRING_AVAIL_ALIGN_SIZE:  => 844:3

arm-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/10562/ (260 out of 263 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/10532/ (260 out of 263 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
