From: Stephen Hemminger via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH 05/14] netvsc: remove no longer needed receive staging
	buffers
Date: Tue, 7 Feb 2017 00:32:12 +0000
Message-ID: <BLUPR0301MB209810C0172361C40F9ABDCBCC430__7684.33044800094$1486432154$gmane$org@BLUPR0301MB2098.namprd03.prod.outlook.com>
References: <20170201162901.3894-1-sthemmin@microsoft.com>
	<20170201162901.3894-6-sthemmin@microsoft.com>
	<DM5PR03MB24909873E83748C02E22AD7CA0410@DM5PR03MB2490.namprd03.prod.outlook.com>
Reply-To: Stephen Hemminger <sthemmin@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <DM5PR03MB24909873E83748C02E22AD7CA0410@DM5PR03MB2490.namprd03.prod.outlook.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: KY Srinivasan <kys@microsoft.com>, Stephen Hemminger <stephen@networkplumber.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

The netvsc part is already in net-next.  This patch is not needed.
The part that removes the per-channel state can be in another patch.
