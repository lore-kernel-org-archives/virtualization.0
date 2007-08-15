From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH 18/25][V3] turn priviled operations into macros in
	entry.S
Date: Wed, 15 Aug 2007 11:19:44 -0300
Message-ID: <5d6222a80708150719x254627f0k40240ac6450f019c__10633.187814574$1187187695$gmane$org@mail.gmail.com>
References: <11871821854176-git-send-email-gcosta@redhat.com>
	<11871823042011-git-send-email-gcosta@redhat.com>
	<11871823151789-git-send-email-gcosta@redhat.com>
	<11871823273810-git-send-email-gcosta@redhat.com>
	<11871823373106-git-send-email-gcosta@redhat.com>
	<11871823673236-git-send-email-gcosta@redhat.com>
	<11871823782610-git-send-email-gcosta@redhat.com>
	<11871823892519-git-send-email-gcosta@redhat.com>
	<11871823991803-git-send-email-gcosta@redhat.com>
	<Pine.LNX.4.58.0708151002001.25252@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.58.0708151002001.25252@gandalf.stny.rr.com>
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
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

>
> Is the .globl really required here? I would think that the reference in
> the fixup section would be resolved with in the compiling of this object.
>
For the fixup yes, you are right. But I'm using this symbol in
paravirt.c now, to denote the native operation.

-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
