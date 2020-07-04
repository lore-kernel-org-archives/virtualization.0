From: Colm =?utf-8?q?MacC=C3=A1rthaigh?= <colmmacc-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Date: Fri, 3 Jul 2020 18:45:06 -0700
Message-ID: <BC9E44B2-D3C2-43C7-8F4B-A31477147368@amazon.com>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703113026.GT18446@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200703113026.GT18446-2MMpYkNvuYDjFM9bn6wA6Q@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Hocko <mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "Catangiu, Adrian Costin" <acatan-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org, wad-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bonzini-mXXj517/zsQ@public.gmane.org, "Graf (AWS), Alexander" <graf-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>, "Singh, Balbir" <sblbir-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, "Sandu, Andrei" <sandreim-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, "Brooker, Marc" <mbrooker-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, "Weiss, Radu" <raduweis-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, "Manwaring, Derek" <derekmn-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org



On 3 Jul 2020, at 4:30, Michal Hocko wrote:

> On Fri 03-07-20 10:34:09, Catangiu, Adrian Costin wrote:
>> This patch adds logic to the kernel power code to zero out contents =

>> of
>> all MADV_WIPEONSUSPEND VMAs present in the system during its =

>> transition
>> to any suspend state equal or greater/deeper than Suspend-to-memory,
>> known as S3.
>
> How does the application learn that its memory got wiped? S2disk is an
> async operation and it can happen at any time during the task =

> execution.
> So how does the application work to prevent from corrupted state - =

> e.g.
> when suspended between two memory loads?

The usual trick when using MADV_WIPEONFORK, or BSD=E2=80=99s MAP_INHERIT_=
ZERO, =

is to store a guard variable in the page and to check the variable any =

time that random data is generated.

Here=E2=80=99s an example of Google=E2=80=99s OpenSSL fork BoringSSL:

https://boringssl.googlesource.com/boringssl/+/ad5582985cc6b89d0e7caf0d9c=
c7e301de61cf66/crypto/fipsmodule/rand/fork_detect.c

Checking a guard variable for non-zero status will always happen =

atomically and monotonically (it won=E2=80=99t suddenly flip back) =E2=80=
=A6 which =

is all that=E2=80=99s needed in this case. If userspace applications need=
 to =

build a larger critical section around they can use regular concurrency =

controls, but it really doesn=E2=80=99t come up in this context. With =

WIPEONSUSPEND support in a kernel, I expect to add another madvise() =

call on the existing page. The manyworldsdetector micro-library is an =

example:


https://github.com/colmmacc/manyworldsdetector/blob/master/src/mwd.c

It=E2=80=99d be a new block in the style of lines 43-48.

-
Colm
