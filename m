From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Add macros for acessing lguest fields
Date: Thu, 13 Sep 2007 16:32:53 +1000
Message-ID: <1189665173.32322.17.camel__40633.4734791473$1189665336$gmane$org@localhost.localdomain>
References: <11894484404160-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11894484404160-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: lguest@ozlabs.org, rostedt@goodmiss.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-09-10 at 15:20 -0300, Glauber de Oliveira Costa wrote:
> The assumption that we have an overall irqs_pending flags,
> and a one-to-one lguest <-> task mapping fails to hold on x86_64,
> where we can have multiple puppies, aka vcpus.
> 
> Although ifdefs could be used, it makes the code much more
> unreadable, and other ports are on the way, anyway. So some sort
> of acessor is preferred anyway.

I'd prefer to see the i386 code use vcpus too.  Even if i386 only has
one at present, it's cleaner.

Of course, there'll be a lot of "s/lg/vcpu/" churn, but that's OK.

Thanks,
Rusty.
