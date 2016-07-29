From: Nikos Mavrogiannopoulos <nmav@gnutls.org>
Subject: Re: getrandom waits for a long time when /dev/random is
	insufficiently read from
Date: Fri, 29 Jul 2016 12:24:27 +0200
Message-ID: <CAJU7zaL8G28chcwEEYAquApm2ncPaBjKky4UPaWVy=6B+-rsCA__20927.9712792069$1469899304$gmane$org@mail.gmail.com>
References: <20160728180732.12d38880@alex-desktop>
	<2481163.nONN48TG9I@tauon.atsec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <2481163.nONN48TG9I@tauon.atsec.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephan Mueller <smueller@chronox.de>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Alex Xu <alex_y_xu@yahoo.ca>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 29, 2016 at 7:40 AM, Stephan Mueller <smueller@chronox.de> wrote:
> And finally, you have a coding error that is very very common but fatal when
> reading from /dev/random: you do not account for short reads which implies
> that your loop continues even in the case of short reads.
>
> Fix your code with something like the following:
> int read_random(char *buf, size_t buflen)
> {
>         int fd = 0;
>         ssize_t ret = 0;
>         size_t len = 0;
>
>         fd = open("/dev/random", O_RDONLY|O_CLOEXEC);
>         if(0 > fd)
>                 return fd;
>         do {
>                 ret = read(fd, (buf + len), (buflen - len));
>                 if (0 < ret)
>                         len += ret;
>         } while ((0 < ret || EINTR == errno || ERESTART == errno)
>                  && buflen > len);

Unless there is a documentation error, the same is required when using
getrandom(). It can also return short as well as to be interrupted.

regards,
Nikos
