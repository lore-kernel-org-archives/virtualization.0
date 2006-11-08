From: Zachary Amsden <zach@vmware.com>
Subject: Re: how set_pte_at()'s vaddr and ptep args relate
Date: Tue, 07 Nov 2006 16:19:25 -0800
Message-ID: <4551228D.9060001@vmware.com>
References: <4550E512.1020706@goop.org> <45510672.4000301@vmware.com>
	<45510AFF.3040304@goop.org> <455117C0.2030202@vmware.com>
	<455119DB.2000704@goop.org> <45511DD4.80307@vmware.com>
	<45512195.3060101@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45512195.3060101@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
>> Oh, wow.  Unfortunately, the complexity isn't from how frequent or =

>> rare a kmapped PT access is, it is from it being there at all.
>
> We'll see how it works out.  What actually needs to do cross-process =

> pagetable manipulation?  Fork?  ptrace?

Fork yes, ptrace, maybe, and also the swapper for A-bit clocking.

Zach
