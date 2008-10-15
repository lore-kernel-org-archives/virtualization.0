From: Andrew Biggadike <biggadike@vmware.com>
Subject: Re: [PATCH][RFC] vmchannel a data channel between host and guest.
Date: Wed, 15 Oct 2008 07:18:52 -0700
Message-ID: <20081015141852.GA19554__25395.9377565936$1224082081$gmane$org@vmware.com>
References: <20081012124534.GK11435@redhat.com>
	<48F39443.4070203@codemonkey.ws>
	<20081014090540.GB13153@redhat.com> <48F4A3B8.8050603@us.ibm.com>
	<20081014175900.GA18344@redhat.com>
	<48F4E1F3.3050606@codemonkey.ws>
	<20081015125837.GQ11435@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081015125837.GQ11435@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: Anupam Chanda <anupamc@vmware.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

Gleb Natapov <gleb@redhat.com> wrote:
> > Of course, you should also take a look at VMware's VMCI.  If we're going
> > to have a socket interface, if we can have a compatible userspace
> > interface, that would probably be a good thing.
>
> I looked at what I could find about VMCI (http://pubs.vmware.com/vmci-sdk/index.html).

I believe Anthony intended for you to look at the sockets interface to
VMCI: http://www.vmware.com/pdf/ws65_s2_vmci_sockets.pdf.

The link you referenced was experimental and is actually now
deprecated in favor of the sockets interface.
