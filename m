From: H L <swdevyid@yahoo.com>
Subject: Re: git repository for SR-IOV development?
Date: Thu, 6 Nov 2008 11:58:25 -0800 (PST)
Message-ID: <104014.9320.qm__10780.1081183881$1226001658$gmane$org@web45110.mail.sp1.yahoo.com>
References: <20081106165914.GA13476@kroah.com>
Reply-To: swdevyid@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081106165914.GA13476@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: randy.dunlap@oracle.com, Xen-devel List <xen-devel@lists.xensource.com>, grundler@parisc-linux.org, achiang@hp.com, matthew@wil.cx, linux-pci@vger.kernel.org, rdreier@cisco.com, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

--- On Thu, 11/6/08, Greg KH <greg@kroah.com> wrote:

> On Thu, Nov 06, 2008 at 08:51:09AM -0800, H L wrote:
> > 
> > Has anyone initiated or given consideration to the
> creation of a git
> > repository (say, on kernel.org) for SR-IOV
> development?
> 
> Why?  It's only a few patches, right?  Why would it
> need a whole new git
> tree?


So as to minimize the time and effort patching a kernel, especially if the tree (and/or hash level) against which the patches were created fails to be specified on a mailing-list.  Plus, there appears to be questions raised on how, precisely, the implementation should ultimately be modeled and especially given that, who knows at this point what number of patches will ultimately be submitted?  I know I've built the "7-patch" one (painfully, by the way), and I'm aware there's another 15-patch set out there which I've not yet examined.
