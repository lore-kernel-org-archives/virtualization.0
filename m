From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 05/14] netvsc: remove no longer needed receive staging
	buffers
Date: Fri, 10 Feb 2017 15:55:33 +0100
Message-ID: <20170210145533.GE24594@kroah.com>
References: <20170201162901.3894-1-sthemmin@microsoft.com>
	<20170201162901.3894-6-sthemmin@microsoft.com>
	<DM5PR03MB24909873E83748C02E22AD7CA0410@DM5PR03MB2490.namprd03.prod.outlook.com>
	<BLUPR0301MB209810C0172361C40F9ABDCBCC430@BLUPR0301MB2098.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <BLUPR0301MB209810C0172361C40F9ABDCBCC430@BLUPR0301MB2098.namprd03.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <sthemmin@microsoft.com>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 07, 2017 at 12:32:12AM +0000, Stephen Hemminger wrote:
> The netvsc part is already in net-next.  This patch is not needed.
> The part that removes the per-channel state can be in another patch.

I have no idea what that means to me here, nor what I need to do, so I'm
just deleting this email :)

thanks,

greg k-h
