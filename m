From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: EXPORT_SYMBOL_GPL(paravirt_ops);
Date: Sun, 13 Aug 2006 11:40:03 -0600
Message-ID: <m18xlswn4c.fsf@ebiederm.dsl.xmission.com>
References: <44DB73F5.5040009@goop.org>
	<20060810183250.GJ2654@sequoia.sous-sol.org>
	<44DB84CA.6040900@vmware.com>
	<20060810194058.GK2654@sequoia.sous-sol.org>
	<44DB95DF.8010805@vmware.com>
	<20060810205505.GM2654@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20060810205505.GM2654@sequoia.sous-sol.org> (Chris Wright's
	message of "Thu, 10 Aug 2006 13:55:05 -0700")
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright <chrisw@sous-sol.org> writes:

> * Zachary Amsden (zach@vmware.com) wrote:
>> But my point is that if you patch everything in the paravirt_ops struct, =

>> no module other than the paravirt_ops backend code needs paravirt_ops =

>> access, so paravirt_ops can still be GPL only.  The problem is you would =

>> need to patch everything.
>
> Oh, I see what you mean, yes.  There was some discussion of that,
> basically run through generic patch, then ->patch() or some such.

There is another solution.  You can simply make the users of paravirt_ops
that aren't important enough to patch static functions in the kernel.

That plus the removal from the callers that always get patched should
make the GPL export safe.

Eric
