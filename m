From: H L <swdevyid@yahoo.com>
Subject: Re: [PATCH 0/16 v6] PCI: Linux kernel SR-IOV support
Date: Thu, 6 Nov 2008 07:40:12 -0800 (PST)
Message-ID: <909674.99469.qm__33348.3267379508$1225987783$gmane$org@web45112.mail.sp1.yahoo.com>
References: <20081106044828.GA30417@kroah.com>
Reply-To: swdevyid@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081106044828.GA30417@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yu Zhao <yu.zhao@intel.com>, Greg KH <greg@kroah.com>
Cc: randy.dunlap@oracle.com, grundler@parisc-linux.org, achiang@hp.com, matthew@wil.cx, linux-pci@vger.kernel.org, rdreier@cisco.com, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org


Greetings (from a new lurker to the list),

To your question Greg, "yes" and "sort of" ;-).  I have started taking a look at these patches with a strong interest in understanding how they work.  I've built a kernel with them and tried out a few things with real SR-IOV hardware.

--
Lance Hartmann




--- On Wed, 11/5/08, Greg KH <greg@kroah.com> wrote:
> 
> Is there any actual users of this API around yet?  How was
> it tested as
> there is no hardware to test on?  Which drivers are going
> to have to be
> rewritten to take advantage of this new interface?
> 
> thanks,
> 
> greg k-h
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/virtualization
