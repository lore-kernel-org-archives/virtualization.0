From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [patch -resend] xen/privcmd: fix condition in privcmd_close()
Date: Wed, 15 May 2013 10:23:22 -0400
Message-ID: <20130515142322.GK15529@phenom.dumpdata.com>
References: <20121105064217.GA26179@elgon.mountain>
	<20130515065624.GA20381@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130515065624.GA20381@elgon.mountain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 15, 2013 at 09:56:24AM +0300, Dan Carpenter wrote:
> The parenthesis are in the wrong place so the original code is
> equivalent to:
> 
> 	if (!xen_feature(0x1)) { ...
> Or:
>         if (!xen_feature(XENFEAT_writable_descriptor_tables)) { ...
> 
> Which obviously was not intended.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> I sent this last November but it was never merged.

Ah, it was, but in a different branch (stable/pvh.v8). Let me stick it on branch for Linus.
