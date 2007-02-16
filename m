From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: Re: [patch 14/21] Xen-paravirt: Add XEN config options
	and disable unsupported config options.
Date: Fri, 16 Feb 2007 14:53:14 +0100
Message-ID: <45D5B74A.6060905@suse.de>
References: <20070216022449.739760547@goop.org>	<20070216022531.570154735@goop.org>
	<45D54BFF.80100@vmware.com>
	<m11wkqimjd.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <m11wkqimjd.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Zachary Amsden <zach@vmware.com>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, Avi Kivity <avi@qumranet.com>, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> Have machine_kexec_prepare fail.
> 
> I think your machine description or paravirt_ops or whatever it is needs
> to hook both machine_kexec_prepare and machine_kexec.
> 
> I know there actually has been some work to get kexec actually working under
> Xen but I don't know where that has gone.

Works, modulo bugs.  Shouldn't be hard to get work on top of
paravirt_ops.  The current 2.6.18 code uses function pointers already
because the dom0 code looks very different from domU code.  It is one of
the items on my todo list.  I'll probably look into it once I'm done
with the earlyprintk and console mess ...

cheers,
  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
