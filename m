From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: Extending boot protocol & bzImage for paravirt_ops
Date: Thu, 31 May 2007 13:38:17 +0530
Message-ID: <20070531080817.GB8685@in.ibm.com>
References: <4656FB8F.4090604@goop.org>
	<m14pm0c0m2.fsf@ebiederm.dsl.xmission.com>
	<465E05E7.20409@goop.org>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <465E05E7.20409@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 30, 2007 at 04:16:55PM -0700, Jeremy Fitzhardinge wrote:
> Eric W. Biederman wrote:
> > I think we should start there and be prepared to munge the ELF
> > magic number if there are problems.  Placing ELF notes is going
> > to require a little work but mostly it should be a matter of
> > copying the from vmlinux.
> >   
> 
> Do you have a semi-current ELF bzImage patch on hand I can start playing
> with?
>

Following is the link to the patch which was posted last time and made
into -mm. But andrew had some old Fedora machine (I think FC2) and some
lilo version on that machine which failed to boot, hence this patch was
dropped.

http://marc.info/?l=linux-kernel&m=115989722229057&w=2

Thanks
Vivek
