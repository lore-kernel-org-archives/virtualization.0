From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] tools: Unify export.h
Date: Tue, 25 Feb 2014 12:09:23 +1030
Message-ID: <87eh2s55tg.fsf__45820.9448880099$1393307216$gmane$org@rustcorp.com.au>
References: <1393153753-2369-1-git-send-email-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1393153753-2369-1-git-send-email-bp@alien8.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Cc: virtio-dev@lists.oasis-open.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Sasha Levin <sasha.levin@oracle.com>, Borislav Petkov <bp@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

Borislav Petkov <bp@alien8.de> writes:
> From: Borislav Petkov <bp@suse.de>
>
> So tools/ has been growing three, at a different stage of their
> development export.h headers and so we should unite into one. Add
> tools/include/ to the include path of virtio and liblockdep to pick the
> shared header now.

Should we get more ambitious and start a fake-kernel/ directory where
we can put userspace equivs/stubs of kernel functionality?

Cheers,
Rusty.
