From: Andi Kleen <ak@suse.de>
Subject: Re: Section mismatch in parainstructions
Date: Tue, 12 Dec 2006 04:21:17 +0100
Message-ID: <200612120421.17639.ak@suse.de>
References: <20061210155821.d2c5dfa5.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061210155821.d2c5dfa5.randy.dunlap@oracle.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
Cc: Randy Dunlap <randy.dunlap@oracle.com>, akpm <akpm@osdl.org>, sam@ravnborg.org
List-Id: virtualization@lists.linuxfoundation.org

On Monday 11 December 2006 00:58, Randy Dunlap wrote:
> =

> Is it OK for section .parainstructions to reference
> exit.text?

Yes it's ok because

 /* .exit.text is discard at runtime, not link time, to deal with references
     from .altinstructions and .eh_frame */

Same applies to paravirtops patching.

-Andi
