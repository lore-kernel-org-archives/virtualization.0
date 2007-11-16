From: Zachary Amsden <zach@vmware.com>
Subject: Re: paravirt_alloc_pd_clone() useful?
Date: Fri, 16 Nov 2007 14:00:41 -0800
Message-ID: <1195250441.6352.207.camel@bodhitayantram.eng.vmware.com>
References: <473DEE66.1020507@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <473DEE66.1020507@goop.org>
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
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-11-16 at 11:24 -0800, Jeremy Fitzhardinge wrote:
> Do you use paravirt_alloc_pd_clone()?  I seem to you remember you
> mentioning that it doesn't help you very much.  I'm in the process of
> unifying pgalloc*, and it seems to me that it would be a bit cleaner
> without needing to worry about paravirt_alloc_pd_clone()...

Yes, we do, and it is one of our largest performance gains.  It is
clone_pgd_range() that turned out not to be useful.

Zach
