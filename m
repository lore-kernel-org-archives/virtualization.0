From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/2] params: <level>_initcall-like kernel parameters
Date: Thu, 15 Dec 2011 14:21:00 +1030
Message-ID: <871us6sdaz.fsf@rustcorp.com.au>
References: <1323712401.2391.93.camel@hornet.cambridge.arm.com>
	<1323712627-17353-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1323712627-17353-1-git-send-email-pawel.moll@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Pawel Moll <pawel.moll@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 12 Dec 2011 17:57:06 +0000, Pawel Moll <pawel.moll@arm.com> wrote:
> This patch adds a set of macros that can be used to declare
> kernel parameters to be parsed _before_ initcalls at a chosen
> level are executed. Such parameters are marked using existing
> "flags" field of the "kernel_param" structure.
> 
> Linker macro collating init calls had to be modified in order
> to add additional symbols between levels that are later used
> by the init code to split the calls into blocks.

This patch wasn't quite what I was thinking, but I've realized that
we can't put the params in the .init section, your approach is probably
the best one.

Note that I've just created a series which gets rid of that silly ISBOOL
thing, so you can use the whole field for "level".  Then I set the level
to -1 for the normal calls; I want to use -2 for the early calls, but
that's not done yet...

I'll rework and rebase your patch like that now.

Thanks!
Rusty.
