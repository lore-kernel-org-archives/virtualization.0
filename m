From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/6] Input: Update vmmouse.c to use the common VMW_PORT
	macros
Date: Tue, 1 Dec 2015 16:01:00 -0800
Message-ID: <20151202000100.GA5363__39118.4973683723$1449014481$gmane$org@kroah.com>
References: <1449008047-8252-1-git-send-email-syeh@vmware.com>
	<1449008332-9394-1-git-send-email-syeh@vmware.com>
	<1449008332-9394-3-git-send-email-syeh@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1449008332-9394-3-git-send-email-syeh@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sinclair Yeh <syeh@vmware.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, pv-drivers@vmware.com, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-graphics-maintainer@vmware.com, linux-input@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 01, 2015 at 02:18:49PM -0800, Sinclair Yeh wrote:
> v2:
> Instead of replacing existing VMMOUSE defines, only modify enough
> to use the new VMW_PORT define.
> 
> v3:
> Use updated VMWARE_PORT() which requires hypervisor magic as an added
> parameter

Why are these here and not below the --- line?

And no changelog text at all?  Not acceptable :(

greg k-h
