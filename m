From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [kvm-devel] [PATCH] virtio_ring: make structure defines packed
Date: Mon, 11 Feb 2008 13:55:22 +0100
Message-ID: <200802111355.22449.borntraeger__37118.1583068848$1202737074$gmane$org@de.ibm.com>
References: <200802081401.21194.borntraeger@de.ibm.com>
	<13426df10802092232w327a96f9ueca5370df826a674@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <13426df10802092232w327a96f9ueca5370df826a674@mail.gmail.com>
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
To: ron minnich <rminnich@gmail.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Sonntag, 10. Februar 2008 schrieb ron minnich:
> The problem for me is that gcc packed is not compatible with the plan
> 9 C compiler. So, for a truly heterogeneous setup, you are going to
> have
> to have code to marshall the structures when transferring between
> domains, and you are better off not trying to fake it with packed --
> it can actually make the
> marshalling less efficient.

Ok, I am conviced. The packed idea came up for mixed platform setups, but 
you are right - this reuqires much more.

Christian
