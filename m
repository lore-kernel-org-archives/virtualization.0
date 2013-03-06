From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH vringh] virtio: Introduce vringh wrappers in virtio_config
Date: Wed, 6 Mar 2013 14:16:40 +0200
Message-ID: <CAK=WgbZtst9G9xBkLXFhpJm6YQxYHVaxjLhZ53P-fmR_NxU+tA@mail.gmail.com>
References: <1362491468-16681-1-git-send-email-sjur.brandeland@stericsson.com>
	<876215cf5f.fsf@rustcorp.com.au>
	<CANHm3Pg6tDMb9fM60sFdA2sQ856vUGe4S1TpK3_tUoyBd-882A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CANHm3Pg6tDMb9fM60sFdA2sQ856vUGe4S1TpK3_tUoyBd-882A@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Sjur_Br=E6ndeland?= <sjur@brendeland.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Erwan Yvin <erwan.yvin@stericsson.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 6, 2013 at 12:50 PM, Sjur Br=E6ndeland <sjur@brendeland.net> wr=
ote:
> The caif_virtio driver is using both host and guest ring sides, host side
> rings in RX direction and guest side rings in TX direction. The reason
> behind this is to enable zero-copy on the producer sides.
> (For details see recent discussion with Ohad "Wrappers for vringh"

FWIW, I'm not convinced that host side rings are necessary for
zero-copy - you could always just pass pointers to your huge data
inside buffers posted by guest side rings.

That said, I do believe that mixing guest side and host side rings may
simplify the overall solution in some cases, especially in more
complex multi core scenarios (where several cores all communicate with
each other).
