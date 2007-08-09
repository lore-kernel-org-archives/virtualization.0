From: "ron minnich" <rminnich@gmail.com>
Subject: Re: [PATCH] Fix Malicious Guest GDT Host Crash
Date: Wed, 8 Aug 2007 21:40:04 -0700
Message-ID: <13426df10708082140r61dbaf0m7f03da23e8bf0421@mail.gmail.com>
References: <1186546220.17470.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1186546220.17470.23.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lguest <lguest@ozlabs.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 8/7/07, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Hi all,
>
>         Testing would be appreciated (esp. Ron?): I'd like to push this as soon
> as possible into 2.6.23.  I thought of it while pondering kvm-lite, and
> then proved it was a problem...

Works fine here.

Be aware that in the early Plan 9 port to lguest I created a gdt entry
and forgot to wrap the GDT #  with a macro with the result that I
loaded a gdt # instead of a selector into the gdt entry, and when the
guest switched back to the host (and back to guest, I guess) it
crashed my machine so hard that it went into the BIOS 'let's set this
brand new thinkpad up' dialog. Do not pass GPF, do not collect your
mental state. It was pretty cool. I have lost disks to that failure
mode before, however, so it was also more excitement than I needed at
that particular time. I can try to find that bogus code (it's plan 9
after all, I've got all versions of the file) unless you know what I
mean here. I would rather not try to repeat the crash.

So, the 'GPF on bogus GDT entry' may not always be there for you. I
did not think it was possible to crash a machine this hard anymore; I
was wrong.

The guys at the Plan 9  BOF at Google thought lguest was pretty darn cool.

Thanks

ron
