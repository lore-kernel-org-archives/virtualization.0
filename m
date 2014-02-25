From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] tools: Unify export.h
Date: Tue, 25 Feb 2014 08:00:20 +0100
Message-ID: <20140225070020.GA19504__2563.63449520922$1393431000$gmane$org@pd.tnic>
References: <1393153753-2369-1-git-send-email-bp@alien8.de>
	<87eh2s55tg.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87eh2s55tg.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtio-dev@lists.oasis-open.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Sasha Levin <sasha.levin@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 25, 2014 at 12:09:23PM +1030, Rusty Russell wrote:
> Should we get more ambitious and start a fake-kernel/ directory where
> we can put userspace equivs/stubs of kernel functionality?

Dunno - people like to do that now, it seems.

In any case, cleanups and unifications like that would definitely help
if we decide to do that because, in this particular example, we have
only one export.h to go and fish out.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
