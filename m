From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/4] Drivers: hv: Support the newly introduced KVP messages
 in the driver
Date: Sun, 11 Mar 2012 12:01:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1203111157590.5402-100000@netrider.rowland.org>
References: <20120311104230.GC3337@mwanda>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120311104230.GC3337@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 11 Mar 2012, Dan Carpenter wrote:

> Btw I don't know if utf16s_to_utf8s() counts the NUL char or not.
> It feels like maybe we could end up with ->value_size equal to
> HV_KVP_EXCHANGE_MAX_VALUE_SIZE + 1.

It does not count NUL characters.  If it encounters a NUL character in
the input, it stops right away without copying that character to the
output.  If it reaches the end of the input, it does not add a
terminating NUL character to the output.

Alan Stern
