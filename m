From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/13] drivers: hv: kvp
Date: Thu, 21 Jun 2012 15:47:37 -0700
Message-ID: <20120621224737.GA5933@kroah.com>
References: <1340314200-27078-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1340314200-27078-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, apw@canonical.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 21, 2012 at 02:30:00PM -0700, K. Y. Srinivasan wrote:
> This patchset expands the KVP (Key Value Pair) functionality to
> implement the mechanism to get/set IP addresses in the guest. This
> functionality is used in Windows Server 2012 to implement VM
> replication functionality. The way IP configuration information
> is managed is distro specific. The current implementation supports
> RedHat way of doing things. We will expand support to other distros
> incrementally. 

I'm missing 09/13, did it get stuck somewhere?
