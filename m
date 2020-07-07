From: Michal Hocko <mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Date: Tue, 7 Jul 2020 09:40:36 +0200
Message-ID: <20200707074036.GB3820@dhcp22.suse.cz>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703113026.GT18446@dhcp22.suse.cz>
 <BC9E44B2-D3C2-43C7-8F4B-A31477147368@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BC9E44B2-D3C2-43C7-8F4B-A31477147368-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Colm =?iso-8859-1?Q?MacC=E1rthaigh?= <colmmacc-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>
Cc: "Catangiu, Adrian Costin" <acatan-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org, wad-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bonzini-mXXj517/zsQ@public.gmane.org, "Graf (AWS), Alexander" <graf-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>, "Singh, Balbir" <sblbir-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, "Sandu, Andrei" <sandreim-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, "Brooker, Marc" <mbrooker-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, "Weiss, Radu" <raduweis-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, "Manwaring, Derek" <derekmn-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri 03-07-20 18:45:06, Colm MacCárthaigh wrote:
> 
> 
> On 3 Jul 2020, at 4:30, Michal Hocko wrote:
> 
> > On Fri 03-07-20 10:34:09, Catangiu, Adrian Costin wrote:
> > > This patch adds logic to the kernel power code to zero out contents
> > > of
> > > all MADV_WIPEONSUSPEND VMAs present in the system during its
> > > transition
> > > to any suspend state equal or greater/deeper than Suspend-to-memory,
> > > known as S3.
> > 
> > How does the application learn that its memory got wiped? S2disk is an
> > async operation and it can happen at any time during the task execution.
> > So how does the application work to prevent from corrupted state - e.g.
> > when suspended between two memory loads?
> 
> The usual trick when using MADV_WIPEONFORK, or BSD’s MAP_INHERIT_ZERO, is to
> store a guard variable in the page and to check the variable any time that
> random data is generated.

Well, MADV_WIPEONFORK is a completely different beast because the
forking is under a full control of the parent process and the
information about the fork can be forwarded to child process. It is
not like the child would reborn into a new world in the middle of the
execution.

-- 
Michal Hocko
SUSE Labs
