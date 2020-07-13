From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Date: Mon, 13 Jul 2020 10:02:06 +0200
Message-ID: <20200713080206.GD16783@dhcp22.suse.cz>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703113026.GT18446@dhcp22.suse.cz>
 <CAG48ez2O2z4L=n57Omwy6s1sWQkdTkPKiikhbfdVhiyd_TGRRw@mail.gmail.com>
 <20200707073823.GA3820@dhcp22.suse.cz> <20200707080726.GA32357@amd>
 <20200707085847.GA5913@dhcp22.suse.cz> <20200707163758.GA1947@amd>
 <E6B41570-E206-4458-921B-465B9EF74949@amazon.com>
 <20200712072228.GB4721@duo.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200712072228.GB4721@duo.ucw.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Weiss, Radu" <raduweis@amazon.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, mingo@kernel.org, Jann Horn <jannh@google.com>, "Brooker,
 Marc" <mbrooker@amazon.com>, "Singh, Balbir" <sblbir@amazon.com>, len.brown@intel.com, bonzini@gnu.org, "Graf (AWS),
 Alexander" <graf@amazon.de>, keescook@chromium.org, linux-pm@vger.kernel.org, "Catangiu, Adrian Costin" <acatan@amazon.com>, Colm MacCarthaigh <colmmacc@amazon.com>, fweimer@redhat.com, wad@chromium.org, linux-api@vger.kernel.org, "Manwaring, Derek" <derekmn@amazon.com>, rjw@rjwysocki.net, luto@amacapital.net, "Sandu, Andrei" <sandreim@amazon.com>, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun 12-07-20 09:22:28, Pavel Machek wrote:
> On Tue 2020-07-07 12:00:41, Colm MacCarthaigh wrote:
> > 
> > 
> > On 7 Jul 2020, at 9:37, Pavel Machek wrote:
> > > Please go through the thread and try to understand it.
> > > 
> > > You'd need syscalls per get_randomness(), not per migration.
> > 
> > I think one check per get_randomness() is sufficient, though putting it at
> > the end of the critical section rather than the beginning helps.
> 
> Yeah, well, one syscall is still enough to make it useless.

I am sorry but I really do not follow. Why would you want to call a
syscall on each get_randomness invocation? Why is it not enough to
simply have a flag that tells that an external event has happened
and reinitialize if the flag is set? Yes this wouldn't be really sync
operation but does that matter? Is using a few random numbers from the
old pool just because the notifier hasn't processed and flag the
situation a major security concern?

Btw. let me just clarify that I am not by any means pushing a solution
like that. All I am saying is that MADV_WIPEONSUSPEND is inherently
subtle interface that we likely want to avoid.
-- 
Michal Hocko
SUSE Labs
