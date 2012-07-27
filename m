From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [vmw_vmci 00/11] VMCI for Linux
Date: Thu, 26 Jul 2012 18:46:50 -0700
Message-ID: <20120727014650.GB17168@kroah.com>
References: <1343345980-32397-1-git-send-email-astiegmann@vmware.com>
	<CA+5PVA6RFthz5vjf-0BOogocMEwVKn5uE2q1_frjPFoVeUPACg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CA+5PVA6RFthz5vjf-0BOogocMEwVKn5uE2q1_frjPFoVeUPACg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Josh Boyer <jwboyer@gmail.com>
Cc: pv-drivers@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, vm-crosstalk@vmware.com, "Andrew Stiegmann (stieg)" <astiegmann@vmware.com>, cschamp@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 26, 2012 at 09:06:25PM -0400, Josh Boyer wrote:
> On Thu, Jul 26, 2012 at 7:39 PM, Andrew Stiegmann (stieg)
> <astiegmann@vmware.com> wrote:
> >  drivers/misc/Kconfig                      |    1 +
> >  drivers/misc/Makefile                     |    1 +
> >  drivers/misc/vmw_vmci/Kconfig             |   16 +
> 
> Is there a reason this isn't going into staging first?  The Hyper-V
> drivers went through staging and that actually seemed to work fairly
> well.

Is there some reason you feel this should be in the staging tree now?
Why?

greg k-h
