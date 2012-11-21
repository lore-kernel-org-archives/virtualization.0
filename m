From: Andy King <acking@vmware.com>
Subject: Re: [Pv-drivers] [PATCH 01/12] VMCI: context implementation.
Date: Wed, 21 Nov 2012 13:10:18 -0800 (PST)
Message-ID: <904751617.29421555.1353532218495.JavaMail.root@vmware.com>
References: <1353531886.24807.43.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1353531886.24807.43.camel@joe-AO722>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, George Zhang <georgezhang@vmware.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Joe,

> Just some trivial notes.

Thanks for taking a look!

> > +		pr_warn("Failed to allocate memory for VMCI context.\n");
> 
> OOM logging messages aren't necessary as alloc failures
> are already logged with a stack trace.

Noted, we'll remove all such occurrences.

> Maybe just use
> 	struct vmci_event_msg e_msg;
> 	struct vmci_event_payld_ctx ev_payload;
> and change the addressing or use a cast as appropriate?

It does seem inelegant, we'll take a look.

> You also have some inconsistency in whether or not your
> logging messages use a terminating period.  I suggest
> you just delete all the periods.
> 	s/\.\\n"/\\n"/g

Gah, that's ugly.  We'll remove all of them as you suggest.

Thanks!
- Andy
